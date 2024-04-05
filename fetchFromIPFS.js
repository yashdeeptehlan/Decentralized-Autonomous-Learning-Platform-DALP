const axios = require("axios");
const ipfsUrl = "https://coffee-effective-nightingale-463.mypinata.cloud/ipfs/QmTiHgmUA9bDjb1oRZeVJZz4hzJnuoPNPUVcMWRyt8gR4h"; // IPFS URL
axios
  .get(ipfsUrl)
  .then((response) => {
    // Handle successful response
    console.log(response.data); // Content retrieved from IPFS
  })
  .catch((error) => {
    // Handle error
    console.error("Error fetching content from IPFS:", error);
  });
