CREATE VIEW aktiveKollegen_MaxMueller AS 
 SELECT DISTINCT fahrer.vorname,
    fahrer.nachname,
    fahrer.handynummer
   FROM fahrer,
    faehrt_in,
    gebiet
  WHERE fahrer.fahrerid = faehrt_in.fahrerid 
  AND NOT fahrer.fahrerid = 100 
  AND faehrt_in.plz::text = gebiet.plz::text 
  AND gebiet.bezirk::text = 'Mitte'::text 
  AND fahrer.aktiv = true;

CREATE VIEW meineLieferungen_MaxMueller AS
   SELECT DISTINCT lieferung.lieferstrasse,
    lieferung.lieferhausnummer,
    lieferung.lieferplz,
    lieferung.status,
    spende.kategorie,
    spende.menge,
    spende.spendername,
    spende.spenderstrasse,
    spende.spenderhausnummer,
    spender.spenderplz
   FROM lieferung,
    spende,
    fahrer,
    spender,
    gebiet,
    liefert
  WHERE NOT lieferung.status = 'neu'::statustype 
  AND spender.spenderstrasse::text = spende.spenderstrasse::text 
  AND spender.spenderhausnummer::text = spende.spenderhausnummer::text 
  AND spender.spendername::text = spende.spendername::text 
  AND spende.lieferid = lieferung.lieferid 
  AND spender.spenderplz::text = gebiet.plz::text 
  AND liefert.fahrerid = 100
  AND liefert.lieferid = lieferung.lieferid;

CREATE VIEW neueLieferungen_MaxMueller AS
 SELECT DISTINCT lieferung.lieferstrasse,
    lieferung.lieferhausnummer,
    lieferung.lieferplz,
    lieferung.status,
    spende.kategorie,
    spende.menge,
    spende.spendername,
    spende.spenderstrasse,
    spende.spenderhausnummer,
    spender.spenderplz
   FROM lieferung,
    spende,
    fahrer,
    spender,
    gebiet
  WHERE lieferung.status = 'neu'::statustype 
  AND spender.spenderstrasse::text = spende.spenderstrasse::text 
  AND spender.spenderhausnummer::text = spende.spenderhausnummer::text 
  AND spender.spendername::text = spende.spendername::text 
  AND spende.lieferid = lieferung.lieferid 
  AND spender.spenderplz::text = gebiet.plz::text 
  AND gebiet.bezirk::text = 'Mitte'::text;

CREATE VIEW JuliaJogurt AS
 SELECT spende.spendenid,
    spende.kategorie,
    spende.menge,
    fahrer.vorname,
    fahrer.nachname,
    fahrer.handynummer,
    lieferung.lieferstrasse,
    lieferung.lieferhausnummer,
    lieferung.lieferplz AS plz,
    lieferung.status
   FROM fahrer,
    liefert,
    lieferung,
    spende
  WHERE liefert.lieferid = lieferung.lieferid 
  AND liefert.fahrerid = fahrer.fahrerid 
  AND spende.lieferid = lieferung.lieferid 
  AND spende.spendername::text = 'JuliaJogurt'::text 
  AND spende.spenderstrasse::text = 'Schloßstraße'::text 
  AND spende.spenderhausnummer::text = '90'::text;

GRANT SELECT ON TABLE public.aktivekollegen_maxmueller TO foodsharing_maxmueller;
GRANT SELECT ON TABLE public.meinelieferungen_maxmueller TO foodsharing_maxmueller;
GRANT SELECT ON TABLE public.neuelieferungen_maxmueller TO foodsharing_maxmueller;

GRANT SELECT ON TABLE public.JuliaJogurt TO foodsharing_juliajogurt;


