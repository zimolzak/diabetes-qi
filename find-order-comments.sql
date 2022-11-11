SELECT TOP 3 *
  FROM [CDWWork].[CPRSOrder].[CPRSOrder]
  where sta3n = 580 and PatientSID > 0 and orderstartDatetime > '2010-01-01'

SELECT TOP 7 *
  FROM [CDWWork].[CPRSOrder].OrderedItem
  where sta3n = 580 and PatientSID > 0

select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = 'CPRSOrder' and DATA_TYPE = 'varchar'
order by CHARACTER_MAXIMUM_LENGTH desc

/*here are all tables/columns that have varchar(8000) columns:

TABLE_NAME	COLUMN_NAME
OrderCheckMessage	OrderCheckMessage
OrderCheckOverrideReason	OverrideReason
OrderAction	OrderText
OrderAction	ExternalText
OrderAction	WardComments
OrderAction_Recent	OrderText
OrderAction_Recent	ExternalText
OrderAction_Recent	WardComments

Going to ignore "_Recent".
Most promising is clearly OrderAction.
*/

select top 14 
      [CPRSOrderSID]      ,[Sta3n]      ,[PatientSID]      ,[OrderStartDateTime]
      ,[OrderActionDateTime]  -- seems boring
      ,[OrderAction]  -- seems boring
      ,[ProviderSID]      ,[TextReference]      ,[OrderText]      ,[ExternalText]      ,[WardComments]
from CDWWork.CPRSOrder.OrderAction
where OrderStartDateTime > '2022-08-01'
  and sta3n = 580




/* how do I get to orderableItem? */

select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = 'cprsorder'
  and COLUMN_NAME = 'orderableItemSID'
-- OrderedItem is the only table that linkes to OrderableItem

select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'cprsorder'
  and COLUMN_NAME like '%SID'

-- orderAction can link back to CPRSOrder.
-- orderedItem also links back to CPRSOrder.




/**** trying multi join ********/

select top 15 * 
into #az_top15ord
from [CDWWork].[CPRSOrder].[CPRSOrder]
where sta3n = 580 and PatientSID > 0 and orderstartDatetime > '2010-01-01'

SELECT 
	c.[CPRSOrderSID],c.[Sta3n],c.[PatientSID],c.[EnteredDateTime],c.[OrderType],c.[InPatientFlag],c.[OrderStartDateTime],
	a.[ProviderSID],a.[TextReference],a.[OrderText],a.[ExternalText],a.[WardComments]
FROM #az_top15ord as c
-- where sta3n = 580 and PatientSID > 0 and orderstartDatetime > '2010-01-01'
left join CDWWork.CPRSOrder.OrderAction as a
on c.CPRSOrderSID = a.CPRSOrderSID
