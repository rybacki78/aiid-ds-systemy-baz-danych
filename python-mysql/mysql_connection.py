import mysql.connector
import config
import numpy as np
from datetime import date
import os

folders_config = config.folders
folder_wzrost = folders_config['wzrost']
folder_wzrost_przetworzone = folders_config['wzrost_przetworzone']

lista_plikow = os.listdir(folder_wzrost)
print(lista_plikow)

mysql_config = config.mysql

db_connection = mysql.connector.connect(
    host=mysql_config['host'],
    port=mysql_config['port'],
    user=mysql_config['user'],
    password=mysql_config['password'],
    database=mysql_config['database']
)

curr = db_connection.cursor()

data_dzisiejsza = date.today()

for plik in lista_plikow:
    plik_sciezka = os.path.join(folder_wzrost, plik)
    plik_sciezka_przetworzone = os.path.join(folder_wzrost_przetworzone, plik)
    dane_wzrost = np.loadtxt(plik_sciezka, delimiter=',')
    for wartosc in dane_wzrost:
        query = "INSERT INTO dane_wzrost (wzrost, data_dodania) VALUES ("+str(wartosc)+",'"+str(data_dzisiejsza)+"')"

        curr.execute(query)
    os.rename(plik_sciezka, plik_sciezka_przetworzone)

    db_connection.commit()

db_connection.close()
