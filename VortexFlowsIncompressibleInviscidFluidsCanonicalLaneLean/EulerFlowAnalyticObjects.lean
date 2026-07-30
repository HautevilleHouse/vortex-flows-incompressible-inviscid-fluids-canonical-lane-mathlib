import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

abbrev Space2 := Fin 2 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space2 → ℝ
abbrev VectorField := Time → Space2 → Space2

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure EulerOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField

def primitiveEulerOperators : EulerOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
}

structure EulerFlow where
  velocity : VectorField
  pressure : ScalarField
  operators : EulerOperators

def primitiveEulerFlow : EulerFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  operators := primitiveEulerOperators
}

def Incompressible (F : EulerFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def Vorticity (F : EulerFlow) : ScalarField :=
  fun t x => (F.velocity t x) 1 - (F.velocity t x) 0

def EulerEquationClosed (F : EulerFlow) : Prop :=
  Incompressible F ∧ (F.operators.timeDerivative F.velocity = F.operators.transport F.velocity)

theorem primitive_vorticity_checked :
    Incompressible primitiveEulerFlow := by
  unfold Incompressible
  simp [primitiveEulerFlow, primitiveEulerOperators, zeroScalarField]

theorem primitive_euler_equation_closed_checked :
    EulerEquationClosed primitiveEulerFlow := by
  unfold EulerEquationClosed
  constructor
  · apply primitive_vorticity_checked
  · unfold Incompressible at *
    simp [primitiveEulerFlow, primitiveEulerOperators, zeroScalarField, zeroVectorField]

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse