/******* NOVEMBER 11. FIND INSULIN IN HOUSTON. ******/

/*
cprsOrder.cprsOrderSID --> OrderedItem.OrderableItemSID --> Dim
cprsOrder.cprsOrderSID --> OrderAction.[OrderText]
*/

select
	OrderableItemSID, OrderableItemName
from dim.OrderableItem
where Sta3n = 580 and
(
	OrderableItemName like '%insulin%' or
	OrderableItemName like '%aspart%' or
	OrderableItemName like '%lispro%' or
	OrderableItemName like '%detemir%' or
	OrderableItemName like '%glargine%'
)
and InactivatedDateTime is null
and InpatientMedCode = 'YES'

/*
9 of them:

1000237950	INSULIN CONC REG HUMAN 500 UNIT/ML 20ML INJ 
1000309490	INSULIN,DETEMIR,HUMAN 100 UNIT/ML INJ 
1000317997	INSULIN,GLARGINE,HUMAN 100 UNIT/ML INJ 
1000348588	INSULIN,ASPART PROTAMIN 70/30 MIX INJ 
1000446651	INSULIN CONC REG HUM 500 UNT/ML KWIKPEN INJ 
1000149742	INSULIN NOVOLIN 70/30 (NPH/REG) INJ 
1000128488	INSULIN LISPRO HUMAN 100 U/ML INJ 
1000150132	INSULIN (HUMAN)NPH,U-100 INJ 
1000220886	INSULIN,ASPART,HUMAN 100 UNT/ML INJ 

-------------

Ideally would like to have data for ~3 months prior to our intervention, which
happened September 25th-October 15th, and looking to collect data for 3 months
after as well if possible.

Meaning:

start 2022-06-25

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
