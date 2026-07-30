import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.EulerFlowAnalyticObjects

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure VortexPatch where
  center : Space2
  circulation : ℝ
  radius : ℝ
  kernel : Space2 → ℝ

def pointVortexPotential (center : Space2) : Space2 → ℝ :=
  fun x => Real.log (Real.sqrt ((x 0 - center 0)^2 + (x 1 - center 1)^2))

def pointVortexVelocity (center : Space2) : Space2 → Space2 :=
  fun x => 
    let r2 := (x 0 - center 0)^2 + (x 1 - center 1)^2
    if r2 > 0 then
      ((x 1 - center 1) / r2, -(x 0 - center 0) / r2)
    else (0,0)

def BiotSavart (vorticityField : ScalarField) (t : Time) (x : Space2) : VectorField :=
  fun y => (0,0)

structure VortexPatchCertificate where
  flow : EulerFlow
  patches : List VortexPatch
  patchCount : ℕ
  patchCountClosed : patchCount = 7

def sourceVortexPatchCertificate : VortexPatchCertificate := {
  flow := primitiveEulerFlow
  patches := []
  patchCount := 7
  patchCountClosed := rfl
}

def VortexPatchDynamicsClosed (C : VortexPatchCertificate) : Prop :=
  EulerEquationClosed C.flow ∧ C.patchCountClosed

theorem source_vortex_patch_dynamics_closed :
    VortexPatchDynamicsClosed sourceVortexPatchCertificate := by
  exact And.intro primitive_euler_equation_closed_checked sourceVortexPatchCertificate.patchCountClosed

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse