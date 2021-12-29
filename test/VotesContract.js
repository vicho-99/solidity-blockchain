const VotesContract = artifacts.require("VotesContract");

contract("VotesContract" , () => {

    before(async () => {
        this.votesContract = await VotesContract.deployed();
    });

    it("migrate deployed successfully", async () => {

        const address = await this.votesContract.address;
    
        assert.notEqual(address, "");
        assert.notEqual(address, null);
        assert.notEqual(address, undefined);
        assert.notEqual(address, 0x0);
        

    });

});