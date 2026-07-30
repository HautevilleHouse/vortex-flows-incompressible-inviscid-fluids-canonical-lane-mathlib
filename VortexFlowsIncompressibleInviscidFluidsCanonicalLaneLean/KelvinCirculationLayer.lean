import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.EulerFlowAnalyticObjects

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure CirculationCertificate where
  flow : EulerFlow
  circulationConserved : Prop
  circulationConservedClosed : circulationConserved

def sourceCirculationCertificate : CirculationCertificate := {
  flow := primitiveEulerFlow
  circulationConserved := Incompressible primitiveEulerFlow
  circulationConservedClosed := by rfl
}

def KelvinCirculationClosed (C : CirculationCertificate) : Prop :=
  EulerEquationClosed C.flow ∧ C.circulationConserved

theorem source_kelvin_circulation_closed :
    KelvinCirculationClosed sourceCirculationCertificate := by
  exact And.intro primitive_euler_equation_closed_checked sourceCirculationCertificate.circulationConservedClosed

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse