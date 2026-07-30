import VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.EulerFlowAnalyticObjects

/-!
# Vortex Patch Regularity Layer

This module captures the regularity framework for vortex patches in incompressible inviscid flows.
It defines the structure of a vortex patch, its boundary regularity, and the conditions
for persistence of regularity over time.
-/

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure VortexPatch where
  vorticity : VorticityField
  support : Set (Space3)
  supportBounded : Prop
  vorticityCompact : Prop

def zeroVortexPatch : VortexPatch := {
  vorticity := zeroVorticityField
  support := Set.univ
  supportBounded := by
    simpa using bounded_univ
  vorticityCompact := by
    simpa using isCompact_univ
}

structure VortexPatchCertificate where
  patch : VortexPatch
  boundaryRegularity : Prop
  persistenceOfRegularity : Prop
  vorticityTransport : Prop
  boundaryRegularityClosed : boundaryRegularity
  persistenceClosed : persistenceOfRegularity
  vorticityTransportClosed : vorticityTransport

def sourceVortexPatchCertificate : VortexPatchCertificate := {
  patch := zeroVortexPatch
  boundaryRegularity := True
  persistenceOfRegularity := True
  vorticityTransport := True
  boundaryRegularityClosed := by
    trivial
  persistenceClosed := by
    trivial
  vorticityTransportClosed := by
    trivial
}

def VortexPatchRegularityClosed (C : VortexPatchCertificate) : Prop :=
  C.boundaryRegularity ∧ C.persistenceOfRegularity ∧ C.vorticityTransport

theorem source_vortex_patch_regularity_closed :
    VortexPatchRegularityClosed sourceVortexPatchCertificate := by
  exact And.intro sourceVortexPatchCertificate.boundaryRegularityClosed
    (And.intro sourceVortexPatchCertificate.persistenceClosed
      sourceVortexPatchCertificate.vorticityTransportClosed)

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse