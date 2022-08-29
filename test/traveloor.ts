import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect, assert } from "chai";
import { Contract, Signer } from "ethers";
import { ethers, network } from "hardhat";
import { Traveloor } from "../typechain";

describe("Test Traveloor contract", function () {
    let deployTraveloor:Traveloor

    const amount = ethers.utils.parseUnits("10")
    before(
        async () => {
            const Traveloor = await ethers.getContractFactory("Traveloor");
            deployTraveloor = await Traveloor.deploy();
         }
    )
    it("should mint flight nft succesfully", async function () {
        const eth = { value : ethers.utils.parseEther("0.1") }
        const mintFlight = await deployTraveloor.mintFlight(eth);
        assert.ok(mintFlight)
      });
    it("should mint train nft succesfully", async function () {
        const eth = { value : ethers.utils.parseEther("0.1") }
        const mintTrain = await deployTraveloor.mintTrain(eth);
        assert.ok(mintTrain)
      });
    it("should mint cruise nft succesfully", async function () {
        const eth = { value : ethers.utils.parseEther("0.1") }
        const mintCruise = await deployTraveloor.mintCruise(eth);
        assert.ok(mintCruise)
      });
    it("should mint hotel nft succesfully", async function () {
        const eth = { value : ethers.utils.parseEther("0.1") }
        const mintHotel = await deployTraveloor.mintHotel(eth);
        assert.ok(mintHotel)
      });
    it("should mint premium nft succesfully", async function () {
        const eth = { value : ethers.utils.parseEther("0.3") }
        const mintPremium = await deployTraveloor.mintPremium(eth);
        assert.ok(mintPremium)
      });
});
      

  
