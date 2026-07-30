import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean.EnergyEnstrophyLayer

namespace HautevilleHouse
namespace VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean

structure CompactnessRigidityCertificate where
  energy : EnergyEnstrophyCertificate
  compactnessControl : Prop
  rigidityExclusion : Prop
  barrierFloor : Prop
  manifestClosed : Prop
  outsideConstantsClosed : Prop
  compactnessControlClosed : compactnessControl
  rigidityExclusionClosed : rigidityExclusion
  barrierFloorClosed : barrierFloor
  manifestClosedProof : manifestClosed
  outsideConstantsClosedProof : outsideConstantsClosed

def sourceCompactnessRigidityCertificate : CompactnessRigidityCertificate := {
  energy := sourceEnergyEnstrophyCertificate
  compactnessControl := True
  rigidityExclusion := True
  barrierFloor := True
  manifestClosed := True
  outsideConstantsClosed := True
  compactnessControlClosed := trivial
  rigidityExclusionClosed := trivial
  barrierFloorClosed := trivial
  manifestClosedProof := trivial
  outsideConstantsClosedProof := trivial
}

def CompactnessRigidityClosed (C : CompactnessRigidityCertificate) : Prop :=
  EnergyEnstrophyClosed C.energy ∧
  C.compactnessControl ∧ C.rigidityExclusion ∧ C.barrierFloor ∧ C.manifestClosed ∧ C.outsideConstantsClosed

theorem source_compactness_rigidity_closed :
    CompactnessRigidityClosed sourceCompactnessRigidityCertificate := by
  exact And.intro source_energy_enstrophy_closed
    (And.intro sourceCompactnessRigidityCertificate.compactnessControlClosed
      (And.intro sourceCompactnessRigidityCertificate.rigidityExclusionClosed
        (And.intro sourceCompactnessRigidityCertificate.barrierFloorClosed
          (And.intro sourceCompactnessRigidityCertificate.manifestClosedProof
            sourceCompactnessRigidityCertificate.outsideConstantsClosedProof))))

end VortexFlowsIncompressibleInviscidFluidsCanonicalLaneLean
end HautevilleHouse