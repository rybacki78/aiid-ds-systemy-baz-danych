-- tabela ligi w randomowych meczy

with podsumowanie as (
   select gospodarz as druzyna,
          sum(gosp_gole) as strzelone,
          sum(gosc_gole) as stracone,
          count(*) as liczba_meczy,
          sum(
             case
                when gosp_gole > gosc_gole then
                   3
                when gosp_gole = gosc_gole then
                   1
                else
                   0
             end
          ) as punkty
     from mecze
    group by gospodarz
   union all
   select gosc,
          sum(gosc_gole) as strzelone,
          sum(gosp_gole) as stracone,
          count(*) as liczba_meczy,
          sum(
             case
                when gosp_gole < gosc_gole then
                   3
                when gosp_gole = gosc_gole then
                   1
                else
                   0
             end
          ) as punkty
     from mecze
    group by gosc
)
select druzyna,
       sum(liczba_meczy) as liczba_meczy,
       sum(punkty) as punkty,
       sum(strzelone) as strzelone,
       sum(stracone) as stracone
  from podsumowanie
 group by druzyna
 order by punkty desc, strzelone - stracone desc, strzelone desc;