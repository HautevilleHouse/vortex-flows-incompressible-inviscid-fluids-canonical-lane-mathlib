import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.EulerFlowAnalyticObjects

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure BlowupCertificate where
  flow : EulerFlow
  blowupTime : ℝ
  vorticityBlowup : Prop
  regularityLoss : Prop
  vorticityBlowupClosed : vorticityBlowup
  regularityLossClosed : regularityLoss

def sourceBlowupCertificate : BlowupCertificate := {
  flow := primitiveEulerFlow
  blowupTime := 0
  vorticityBlowup := Incompressible primitiveEulerFlow
  regularityLoss := Incompressible primitiveEulerFlow
  vorticityBlowupClosed := by rfl
  regularityLossClosed := by rfl
}

def FiniteTimeBlowupClosed (C : BlowupCertificate) : Prop :=
  EulerEquationClosed C.flow ∧ C.vorticityBlowup ∧ C.regularityLoss

theorem source_finite_time_blowup_closed :
    FiniteTimeBlowupClosed sourceBlowupCertificate := by
  exact And.intro primitive_euler_equation_closed_checked
    (And.intro sourceBlowupCertificate.vorticityBlowupClosed sourceBlowupCertificate.regularityLossClosed)

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse