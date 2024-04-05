// Import the necessary modules
const Course = artifacts.require("Course");

contract("Course", (accounts) => {
  let course;
  const owner = accounts[0];
  const user = accounts[1];
  const nonOwner = accounts[2];

  beforeEach(async () => {
    course = await Course.new({ from: owner });
  });

  it("should create a new course", async () => {
    const result = await course.createCourse("https://example.com/course1", {
      from: user,
    });
    assert.equal(result.logs[0].event, "Transfer");
  });

  it("should set the token URI", async () => {
    await course.createCourse("https://example.com/course1", { from: user });
    await course.setTokenURI(1, "https://example.com/course1_updated", {
      from: owner,
    });
    const tokenURI = await course.tokenURI(1);
    assert.equal(tokenURI, "https://example.com/course1_updated");
  });

  it("should not allow non-owner to set token URI", async () => {
    await course.createCourse("https://example.com/course1", { from: user });
    try {
      await course.setTokenURI(1, "https://example.com/course1_updated", {
        from: nonOwner,
      });
      assert.fail("Expected setTokenURI to fail for non-owner");
    } catch (error) {
      assert.equal(error.reason, "Ownable: caller is not the owner");
    }
  });

  it("should not allow setting token URI for non-existent token", async () => {
    try {
      await course.setTokenURI(1, "https://example.com/course1_updated", {
        from: owner,
      });
      assert.fail("Expected setTokenURI to fail for non-existent token");
    } catch (error) {
      assert.equal(
        error.reason,
        "ERC721Metadata: URI set of nonexistent token"
      );
    }
  });

  it("should return correct token URI", async () => {
    await course.createCourse("https://example.com/course1", { from: user });
    const tokenURI = await course.tokenURI(1);
    assert.equal(tokenURI, "https://example.com/course1");
  });

  it("should return correct owner of a token", async () => {
    await course.createCourse("https://example.com/course1", { from: user });
    const ownerOfToken = await course.ownerOf(1);
    assert.equal(ownerOfToken, user);
  });

  it("should not allow transferring a token from a non-owner", async () => {
    await course.createCourse("https://example.com/course1", { from: user });
    try {
      await course.transferFrom(user, nonOwner, 1, { from: nonOwner });
      assert.fail("Expected transferFrom to fail for non-owner");
    } catch (error) {
      assert.equal(
        error.reason,
        "ERC721: transfer caller is not owner nor approved"
      );
    }
  });

});
