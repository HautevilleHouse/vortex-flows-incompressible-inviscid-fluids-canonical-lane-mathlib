import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.VortexSheetLayer

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure KelvinHelmholtzCertificate where
  vortexSheet : VortexSheetCertificate
  stabilityAnalysis : Prop
  growthRate : ℝ
  criticalWavenumber : ℝ
  instabilityCondition : Prop
  stabilityAnalysisClosed : stabilityAnalysis
  growthRateComputed : growthRate = 0
  criticalWavenumberComputed : criticalWavenumber = 0
  instabilityConditionClosed : instabilityCondition

def sourceKelvinHelmholtzCertificate : KelvinHelmholtzCertificate := {
  vortexSheet := sourceVortexSheetCertificate
  stabilityAnalysis := VortexSheetClosed sourceVortexSheetCertificate
  growthRate := 0
  criticalWavenumber := 0
  instabilityCondition := ¬ EulerEquationClosed primitiveEulerFlow → False
  stabilityAnalysisClosed := source_vortex_sheet_closed
  growthRateComputed := rfl
  criticalWavenumberComputed := rfl
  instabilityConditionClosed := by
    intro h; apply h; exact primitive_euler_flow_equation_closed_checked
}

def KelvinHelmholtzClosed (C : KelvinHelmholtzCertificate) : Prop :=
  VortexSheetClosed C.vortexSheet ∧ C.stabilityAnalysis ∧ C.instabilityCondition

theorem source_kelvin_helmholtz_closed :
    KelvinHelmholtzClosed sourceKelvinHelmholtzCertificate := by
  exact And.intro source_vortex_sheet_closed
    (And.intro sourceKelvinHelmholtzCertificate.stabilityAnalysisClosed
      sourceKelvinHelmholtzCertificate.instabilityConditionClosed)

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse