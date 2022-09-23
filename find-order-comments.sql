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
[OrderActionSID]
      ,[CPRSOrderSID]
      ,[CPRSOrderIEN]
      ,[OrderActionIEN]
      ,[Sta3n]
      ,[PatientSID]
      ,[LabReferralPatientSID]
      ,[OrderStartDateTime]
      ,[OrderStartVistaErrorDate]
      ,[OrderStartDateTimeTransformSID]
      ,[OrderActionDateTime]
      ,[OrderActionVistaErrorDate]
      ,[OrderActionDateTimeTransformSID]
      ,[DrugSchedule]
      ,[DigitalSignatureRequiredFlag]
      ,[OrderAction]
      ,[ActionRejectReason]
      ,[DigitalSignature]
      ,[ProviderSID]
      ,[SignatureStatus]
      ,[SignedByStaffSID]
      ,[SignedDateTime]
      ,[SignedVistaErrorDate]
      ,[SignedDateTimeTransformSID]
      ,[SignedOnChartStaffSID]
      ,[VerifyingNurseStaffSID]
      ,[NurseVerifiedDateTime]
      ,[NurseVerifiedVistaErrorDate]
      ,[NurseVerifiedDateTimeTransformSID]
      ,[VerifyingClerkStaffSID]
      ,[ClerkVerifiedDateTime]
      ,[ClerkVerifiedVistaErrorDate]
      ,[ClerkVerifiedDateTimeTransformSID]
      ,[NatureOfOrderSID]
      ,[EnteredByStaffSID]
      ,[TextReference]
      ,[ReleaseStatus]
      ,[ReleaseDateTime]
      ,[ReleaseVistaErrorDate]
      ,[ReleaseDateTimeTransformSID]
      ,[ReleasingStaffSID]
      ,[ChartReviewedByStaffSID]
      ,[ChartReviewedDateTime]
      ,[ChartReviewedVistaErrorDate]
      ,[ChartReviewedDateTimeTransformSID]
      ,[DiscontinuedHoldUntilDateTime]
      ,[DiscontinuedHoldUntilVistaErrorDate]
      ,[DiscontinuedHoldUntilDateTransformSID]
      ,[DiscontinuedHoldReleasedByStaffSID]
      ,[OrderActionFlag]
      ,[OrderActionFlagDateTime]
      ,[OrderActionFlagVistaErrorDate]
      ,[OrderActionFlagDateTimeTransformSID]
      ,[FlaggedByStaffSID]
      ,[RecordFlaggedReason]
      ,[OrderActionUnflaggedDateTime]
      ,[OrderActionUnflaggedVistaErrorDate]
      ,[OrderActionUnflaggedDateTimeTransformSID]
      ,[UnflaggedByStaffSID]
      ,[RecordUnflaggedReason]
      ,[AlertedProviderSID]
      ,[ChartCopyPrintedFlag]
      ,[ChartCopyPrintedDateTime]
      ,[ChartCopyPrintedVistaErrorDate]
      ,[ChartCopyPrintedDateTimeTransformSID]
      ,[ChartCopyPrintedByStaffSID]
      ,[ChartCopyPrinter]
      ,[OrderText]
      ,[ExternalText]
      ,[WardComments]

from CDWWork.CPRSOrder.OrderAction
