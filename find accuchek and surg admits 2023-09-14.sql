SELECT TOP (1000) [LabChemTestSID]
      ,[LabChemTestIEN]
      ,[Sta3n]
      ,[LabChemTestName]
      ,[LabChemPrintTestName]
  FROM [CDWWork].[Dim].[LabChemTest]
  where Sta3n=580 and LabChemTestName like '%gluc%'
  order by LabChemTestName

  /* 1000000291      POC ACC GLUCOSE */





select top 50 
patientsid, LabChemSpecimenDateTime, TopographySID, LabChemResultValue, LabChemResultNumericValue, LOINCSID, units, Abnormal, RefHigh, RefLow
from CDWWork.Chem.LabChem
where labchemtestsid = 1000000291


select top 100
InpatientSID, PatientSID, AdmitDateTime, DischargeDateTime, PrincipalDiagnosisICD10SID, PrincipalDiagnosisICD9SID, AdmitWardLocationSID, AdmitDiagnosis,
    SpecialtyCDR, DischargeFromSpecialtySID, DischargeFromService, ProviderSID
from Inpat.Inpatient
where sta3n = 580
    and PatientSID != 0
    and AdmitDateTime > '2021-01-01'

-- possibly useful AdmitWardLocationSID, DischargeFromSpecialtySID
-- very promising: dischargefromservice

select top 100 * from CDWWork.[Dim].[WardLocation] where sta3n = 580
select specialtysid, specialty, medicalservice, bedsectionname from CDWWork.dim.specialty where sta3n = 580 order by medicalservice desc -- N = 151 rows.

/*
[Dim].[SurgeryDisposition]
[Dim].[SurgeryDispositionSynonym]
[Dim].[Specialty]
[Dim].[ServiceSection]

here are the specialty = XYZ, when medicalservice="SURGERY"

VASCULAR
GENERAL SURGERY
OB/GYN
NEUROSURGERY
OPHTHALMOLOGY
ORTHOPEDIC
EAR, NOSE, THROAT (ENT)
PLASTIC SURGERY
PROCTOLOGY
THORACIC SURGERY
UROLOGY
CARDIAC SURGERY
TRANSPLANTATION
ORAL SURGERY

for vascular, the specialtysid = 1000001127
*/


select top 100
InpatientSID, PatientSID, AdmitDateTime, DischargeDateTime, PrincipalDiagnosisICD10SID, PrincipalDiagnosisICD9SID, AdmitWardLocationSID, AdmitDiagnosis,
    SpecialtyCDR, DischargeFromSpecialtySID, DischargeFromService, ProviderSID
from Inpat.Inpatient
where DischargeFromSpecialtySID = 1000001127
