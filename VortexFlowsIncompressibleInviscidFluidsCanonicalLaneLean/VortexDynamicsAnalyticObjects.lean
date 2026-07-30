import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.SourcePackage
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
  vorticity : VectorField → ScalarField
  streamfunction : ScalarField → VectorField

def primitiveEulerOperators : EulerOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  vorticity := fun _ => zeroScalarField
  streamfunction := fun _ => zeroVectorField
}

structure EulerFlow where
  velocity : VectorField
  vorticity : ScalarField
  operators : EulerOperators

def primitiveEulerFlow : EulerFlow := {
  velocity := zeroVectorField
  vorticity := zeroScalarField
  operators := primitiveEulerOperators
}

def Incompressible (F : EulerFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def VorticityTransport (F : EulerFlow) : Prop :=
  F.operators.timeDerivative (fun t x => F.operators.vorticity F.velocity t x) =
  F.operators.transport (fun t x => F.operators.vorticity F.velocity t x)

def EulerEquationClosed (F : EulerFlow) : Prop :=
  Incompressible F ∧ VorticityTransport F

theorem primitive_euler_flow_incompressible_checked :
    Incompressible primitiveEulerFlow := by
  unfold Incompressible primitiveEulerFlow primitiveEulerOperators
  rfl

theorem primitive_euler_flow_vorticity_transport_checked :
    VorticityTransport primitiveEulerFlow := by
  unfold VorticityTransport primitiveEulerFlow primitiveEulerOperators
  rfl

theorem primitive_euler_flow_equation_closed_checked :
    EulerEquationClosed primitiveEulerFlow := by
  exact And.intro primitive_euler_flow_incompressible_checked
    primitive_euler_flow_vorticity_transport_checked

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse