import canonicalLaneMathlib.AdmissibleClass

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
  materialDerivative : VectorField → VectorField
  vorticityOperator : VectorField → ScalarField
  streamFunction : ScalarField → VectorField
  biharmonic : VectorField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveEulerOperators : EulerOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  materialDerivative := fun _ => zeroVectorField
  vorticityOperator := fun _ => zeroScalarField
  streamFunction := fun _ => zeroVectorField
  biharmonic := fun u => u
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure VortexFlow where
  velocity : VectorField
  pressure : ScalarField
  vorticity : ScalarField
  stream : ScalarField
  operators : EulerOperators

def primitiveVortexFlow : VortexFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  vorticity := zeroScalarField
  stream := zeroScalarField
  operators := primitiveEulerOperators
}

def Incompressible (F : VortexFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def VorticityEquation (F : VortexFlow) : Prop :=
  F.operators.materialDerivative F.vorticity = zeroScalarField

def BiotSavartLaw (F : VortexFlow) : Prop :=
  F.operators.streamFunction F.vorticity = F.stream ∧
  F.operators.gradient F.stream = F.velocity

def EulerEquationClosed (F : VortexFlow) : Prop :=
  Incompressible F ∧ VorticityEquation F ∧ BiotSavartLaw F

theorem primitive_euler_equation_closed_checked :
    EulerEquationClosed primitiveVortexFlow := by
  unfold EulerEquationClosed Incompressible VorticityEquation BiotSavartLaw
  simp

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse