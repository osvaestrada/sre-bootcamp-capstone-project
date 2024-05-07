

const createNetmask = bit => {
    let mask = [], i, n;
    let bitCount = bit;
    for(i=0; i<4; i++) {
        n = Math.min(bitCount, 8);
        mask.push(256 - Math.pow(2, 8-n));
        bitCount -= n;
    }
    return {
        function: "cidrToMask",
        input: bit,
        output: mask.join('.'),
    }
}

module.exports = {
    createNetmask,
}