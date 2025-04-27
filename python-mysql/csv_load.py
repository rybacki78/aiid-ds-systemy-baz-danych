import numpy as np
import os
import mysql.connector
import config

folder1_input = config.folders['csv1']
folder1_processed = config.folders['csv1_processed']

list_files = os.listdir(folder1_input)
print(list_files)

db_connection = mysql.connector.connect(
    host=config.mysql['host'],
    port=config.mysql['port'],
    user=config.mysql['user'],
    password=config.mysql['password'],
    database=config.mysql['database']
)
curr = db_connection.cursor()

for file in list_files:
    file_path = os.path.join(folder1_input, file)
    folder1_path_proceed = os.path.join(folder1_processed, file[9:11])
    file_path_processed = os.path.join(folder1_path_proceed, file)
    csv1_data = np.loadtxt(file_path, delimiter=',')
    for day, hour, numb1, numb2 in csv1_data:
        query = "INSERT INTO csv (day, hour, numb1, numb2) \
                 VALUES (" + str(day) + ", " + str(hour) + ", " + str(numb1) + ", " + str(numb2) + ")"
        curr.execute(query)
    os.makedirs(folder1_path_proceed, exist_ok=True)
    os.rename(file_path, file_path_processed)

    db_connection.commit()

db_connection.close()
