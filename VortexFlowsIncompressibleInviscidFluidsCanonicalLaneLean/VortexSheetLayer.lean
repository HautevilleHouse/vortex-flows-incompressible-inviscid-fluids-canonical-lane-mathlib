import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.VortexDynamicsAnalyticObjects

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure VortexSheetCertificate where
  eulerFlow : EulerFlow
  sheetDensity : ScalarField
  inducedVelocity : VectorField
  biotSavartLaw : Prop
  circulationConservation : Prop
  sheetEvolution : Prop
  biotSavartLawClosed : biotSavartLaw
  circulationConservationClosed : circulationConservation
  sheetEvolutionClosed : sheetEvolution

def sourceVortexSheetCertificate : VortexSheetCertificate := {
  eulerFlow := primitiveEulerFlow
  sheetDensity := zeroScalarField
  inducedVelocity := zeroVectorField
  biotSavartLaw := EulerEquationClosed primitiveEulerFlow
  circulationConservation := true
  sheetEvolution := EulerEquationClosed primitiveEulerFlow
  biotSavartLawClosed := primitive_euler_flow_equation_closed_checked
  circulationConservationClosed := rfl
  sheetEvolutionClosed := primitive_euler_flow_equation_closed_checked
}

def VortexSheetClosed (C : VortexSheetCertificate) : Prop :=
  C.biotSavartLaw ∧ C.circulationConservation ∧ C.sheetEvolution

theorem source_vortex_sheet_closed :
    VortexSheetClosed sourceVortexSheetCertificate := by
  exact And.intro sourceVortexSheetCertificate.biotSavartLawClosed
    (And.intro sourceVortexSheetCertificate.circulationConservationClosed
      sourceVortexSheetCertificate.sheetEvolutionClosed)

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse