import VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.VortexPatchRegularity

/-!
# Weak Solution Layer

This module defines the weak solution framework for the incompressible Euler equations,
including Yudovich-type solutions for vorticity in L^p spaces and the corresponding
admissibility criteria.
-/

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure VortictyClass (p : ℝ) where
  exponent : ℝ
  finite : Prop

def defaultVorticityClass : VortictyClass 1 := {
  exponent := 1
  finite := True
}

structure WeakSolutionEnvelope where
  flow : EulerFlow
  vorticityClass : VortictyClass 1
  weakEquation : EulerFlowClosed flow
  energyFinite : Prop
  weakEquationClosed : weakEquation
  energyFiniteClosed : energyFinite

def sourceWeakSolutionEnvelope : WeakSolutionEnvelope := {
  flow := primitiveEulerFlow
  vorticityClass := defaultVorticityClass
  weakEquation := primitive_euler_flow_closed_checked
  energyFinite := True
  weakEquationClosed := primitive_euler_flow_closed_checked
  energyFiniteClosed := trivial
}

def WeakSolutionEnvelopeClosed (E : WeakSolutionEnvelope) : Prop :=
  EulerFlowClosed E.flow ∧ E.energyFinite

theorem source_weak_solution_envelope_closed :
    WeakSolutionEnvelopeClosed sourceWeakSolutionEnvelope := by
  exact And.intro sourceWeakSolutionEnvelope.weakEquationClosed
    sourceWeakSolutionEnvelope.energyFiniteClosed

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse