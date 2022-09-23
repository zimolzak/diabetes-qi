SELECT TOP 14 *
  FROM [CDWWork].[CPRSOrder].[CPRSOrder]
  where sta3n = 580 and PatientSID > 0

SELECT TOP 14 *
  FROM [CDWWork].[CPRSOrder].OrderedItem
  where sta3n = 580 and PatientSID > 0


/********* dim tables ************/
select top 14 * from CDWWork.dim.OrderableItem
where sta3n = 580

select count(DisplayGroupName) as n, DisplayGroupName from
(
select top 10000 * from CDWWork.dim.OrderableItem
where sta3n = 580) as tt
group by DisplayGroupName
order by n desc

select count(*)
from CDWWork.Dim.OrderableItem
where Sta3n = 580 and DisplayGroupName = 'PHARMACY'
-- N = 8914



select *
from CDWWork.Dim.OrderableItem
where Sta3n = 580 and OrderableItemName like '%insulin%' and DisplayGroupName = 'PHARMACY'
  and InactivatedDateTime is null
-- N = 116 if not lim by displaygroupname.
-- all disp group names for insulin = {consults, laboratory, nursing, other hosp, pharmacy}
-- N = 29 (insulin & pharmacy & null inactivated)
and OrderableItemName not like '%syringe%' and OrderableItemName not like '%needle%' 
-- now down to N = 21
and InpatientMedCode != 'NO' 
-- down to N = 12. Probably disregard field called OutpatientMedFlag because some can be both, it seems.
order by OrderableItemName

-- NPH, regular u100, conc, conc, lispro, novolin 70 30, reg u100 IV, u100 pork IV, asp 70 30, asp, det, glarg
--     1000128601                 1000128488                                                
-- asp 1000220886
-- det 1000309490
-- glarg 1000317997
