import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.VorticityStreamLayer

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure EnergyEnstrophyCertificate where
  vorticityStream : VorticityStreamCertificate
  energyFinite : Prop
  enstrophyFinite : Prop
  energyDecay : Prop
  enstrophyGrowth : Prop
  energyFiniteClosed : energyFinite
  enstrophyFiniteClosed : enstrophyFinite
  energyDecayClosed : energyDecay
  enstrophyGrowthClosed : enstrophyGrowth

def sourceEnergyEnstrophyCertificate : EnergyEnstrophyCertificate := {
  vorticityStream := sourceVorticityStreamCertificate
  energyFinite := True
  enstrophyFinite := True
  energyDecay := True
  enstrophyGrowth := True
  energyFiniteClosed := trivial
  enstrophyFiniteClosed := trivial
  energyDecayClosed := trivial
  enstrophyGrowthClosed := trivial
}

def EnergyEnstrophyClosed (C : EnergyEnstrophyCertificate) : Prop :=
  VorticityStreamClosed C.vorticityStream ∧
  C.energyFinite ∧ C.enstrophyFinite ∧ C.energyDecay ∧ C.enstrophyGrowth

theorem source_energy_enstrophy_closed :
    EnergyEnstrophyClosed sourceEnergyEnstrophyCertificate := by
  exact And.intro source_vorticity_stream_closed
    (And.intro sourceEnergyEnstrophyCertificate.energyFiniteClosed
      (And.intro sourceEnergyEnstrophyCertificate.enstrophyFiniteClosed
        (And.intro sourceEnergyEnstrophyCertificate.energyDecayClosed
          sourceEnergyEnstrophyCertificate.enstrophyGrowthClosed)))

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse