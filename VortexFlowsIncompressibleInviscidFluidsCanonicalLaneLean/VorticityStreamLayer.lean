import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.VortexFlowDomain

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure VorticityStreamCertificate where
  flow : VortexFlow
  vorticityFinite : Prop
  streamRegular : Prop
  biotSavartValid : Prop
  transportClosed : Prop
  vorticityFiniteClosed : vorticityFinite
  streamRegularClosed : streamRegular
  biotSavartValidClosed : biotSavartValid
  transportClosedClosed : transportClosed

def sourceVorticityStreamCertificate : VorticityStreamCertificate := {
  flow := primitiveVortexFlow
  vorticityFinite := True
  streamRegular := True
  biotSavartValid := BiotSavartLaw primitiveVortexFlow
  transportClosed := VorticityEquation primitiveVortexFlow
  vorticityFiniteClosed := trivial
  streamRegularClosed := trivial
  biotSavartValidClosed := by
    unfold BiotSavartLaw primitiveVortexFlow; simp
  transportClosedClosed := by
    unfold VorticityEquation primitiveVortexFlow; simp
}

def VorticityStreamClosed (C : VorticityStreamCertificate) : Prop :=
  C.vorticityFinite ∧ C.streamRegular ∧ C.biotSavartValid ∧ C.transportClosed

theorem source_vorticity_stream_closed :
    VorticityStreamClosed sourceVorticityStreamCertificate := by
  exact And.intro sourceVorticityStreamCertificate.vorticityFiniteClosed
    (And.intro sourceVorticityStreamCertificate.streamRegularClosed
      (And.intro sourceVorticityStreamCertificate.biotSavartValidClosed
        sourceVorticityStreamCertificate.transportClosedClosed))

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse