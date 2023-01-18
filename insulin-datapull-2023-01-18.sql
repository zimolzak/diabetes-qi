/*******
Retrieve the "OrderText" field for insulin orders in Houston, looking for distinctive text.

2023-01-18

How we retrieve insulin products specifically:
  cprsOrder.cprsOrderSID --> OrderedItem.OrderableItemSID --> Dim

How we retrieve the comments or OrderText:
  cprsOrder.cprsOrderSID --> OrderAction.[OrderText]

The SIDs we will pull stand for these meds:
	1000237950	INSULIN CONC REG HUMAN 500 UNIT/ML 20ML INJ 
	1000309490	INSULIN,DETEMIR,HUMAN 100 UNIT/ML INJ 
	1000317997	INSULIN,GLARGINE,HUMAN 100 UNIT/ML INJ 
	1000348588	INSULIN,ASPART PROTAMIN 70/30 MIX INJ 
	1000446651	INSULIN CONC REG HUM 500 UNT/ML KWIKPEN INJ 
	1000149742	INSULIN NOVOLIN 70/30 (NPH/REG) INJ 
	1000128488	INSULIN LISPRO HUMAN 100 U/ML INJ 
	1000150132	INSULIN (HUMAN)NPH,U-100 INJ 
	1000220886	INSULIN,ASPART,HUMAN 100 UNT/ML INJ 

Rationale for dates:
	"Ideally would like to have data for ~3 months prior to our intervention, which
	happened September 25th-October 15th, and looking to collect data for 3 months
	after as well if possible." Meaning: start 2022-06-25
*/

select top 10
	oi.CPRSOrderSID, oi.Sta3n, oi.PatientSID, oi.EnteredDateTime, oi.OrderableItemSID,
	oa.OrderText
from CPRSOrder.OrderedItem as oi
left join CPRSOrder.OrderAction as oa
on oi.CPRSOrderSID = oa.CPRSOrderSID
where
	OrderableItemSID in
	(
		1000237950,
		1000309490,
		1000317997,
		1000348588,
		1000446651,
		1000149742,
		1000128488,
		1000150132,
		1000220886
	) and
	EnteredDateTime > '2022-06-24'
-- this took about 1 minute

/*
Here are some basic results. I sanitized month and date which sometimes creep in there.

INSULIN,GLARGINE,HUMAN 100 UNIT/ML INJ   INJECT 25 UNITS UNDER THE SKIN AT BEDTIME FOR DIABETES. DO NOT MIX WITH OTHER INSULIN. **pls set fill date as XXXX/22**  Quantity: 3 Refills: 3 
INSULIN,ASPART,HUMAN 100 UNT/ML INJ   SLIDING SCALE SUB-Q AC 5 MIN 130-150:        2 units 151-200:        4 units 201-250:        6 units 251-300:        8 units 301-350:       10 units 351-400:       12 units >401:           14 units and call MD 
INSULIN,ASPART,HUMAN 100 UNT/ML INJ  100UNIT/ML  13 UNITS SUB-Q QAM dose decreased  on XXXX/22,  Hold if pt not eating, FOR DM 
INSULIN,ASPART,HUMAN 100 UNT/ML INJ  100UNIT/ML  SLIDING SCALE SUB-Q QAC QBEDTIME 150 - 199:      2 units 200 - 249:      3 units 250 - 299:      4 units 300 - 349:      5 units > 349:          6 units Notify MD for blood glucoses LESS than 70 mg/dL and GREATER than 350 mg/dL 
INSULIN,GLARGINE,HUMAN 100 UNIT/ML INJ  100UNIT/ML  15UNITS SUB-Q QPM Please give around 1700 (5PM) **Decreased while on pureed diet starting on XXXX/22. 
INSULIN,GLARGINE,HUMAN 100 UNIT/ML INJ  100UNIT/ML  INJECT 25 UNITS UNDER THE SKIN AT BEDTIME FOR DIABETES. DO NOT MIX WITH OTHER INSULIN.  Quantity: 3 Refills: 3 

One more specification:

"...just get a few weeks of data from prior to my intervention (around July- August) and currently...."

My notes about dates:

- June 24: the 3 mo point prior to intervention, shouldn't need any before that.
- july: well prior to intervention, get maybe 3 wk data?
- jul-aug, maybe get all 8 weeks if viable performance.
- sept 25, intervention starts
- oct 15, intervention ongoing
- 2022-12-25: should be okay time to start the short 3 wk pull.
- 2023-01-15: the 3 mo after intervention.

CONCLUSION:
DATES TO DO FIRST, IN BRIEF:

July 1 ~ July 22
Dec 25 ~ Jan 15
*/


select
	oi.CPRSOrderSID, oi.Sta3n, oi.PatientSID, oi.EnteredDateTime, oi.OrderableItemSID,
	oa.OrderText
from CPRSOrder.OrderedItem as oi
left join CPRSOrder.OrderAction as oa
on oi.CPRSOrderSID = oa.CPRSOrderSID
where
	OrderableItemSID in
	(
		1000237950,
		1000309490,
		1000317997,
		1000348588,
		1000446651,
		1000149742,
		1000128488,
		1000150132,
		1000220886
	)
	and	EnteredDateTime > '2022-12-24'  --'2022-06-30'
	and	EnteredDateTime < '2023-01-16'  --'2022-07-23'

-- July dates: got about 119 prelim hits at the 1 minute mark
-- final: 3,033 rows. Took 1 min 26 sec.

/*
Standard export procedure:

select all
copy with headers
paste into Notepad
save as txt
import into Excel as TSV
*/
