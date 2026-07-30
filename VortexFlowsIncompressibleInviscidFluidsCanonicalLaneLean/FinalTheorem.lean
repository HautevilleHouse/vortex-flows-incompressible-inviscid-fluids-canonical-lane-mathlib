import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.EulerFlowAnalyticObjects

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

open HautevilleHouse.CanonicalLaneMathlibCore

structure AdmittedTheoremObject where
  object : TheoremSpecificObject
  sourceKeyChecked : object.sourceKey = sourceRepository
  theoremObjectChecked : object.theoremObject = sourceDescription

def bridgeClosed (A : AdmissibleClass) : Prop :=
  NativeBridgeClosed A.object

theorem bridge_from_admissible_class (A : AdmissibleClass) : bridgeClosed A := by
  exact And.intro A.object.sourceKeyChecked A.object.theoremObjectChecked

def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

theorem gate_from_admissible_class (A : AdmissibleClass) : gateClosed A := by
  exact A.gateWitness

def ConstrainedVortexClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_vortex_endgame (A : AdmissibleClass) :
    ConstrainedVortexClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse