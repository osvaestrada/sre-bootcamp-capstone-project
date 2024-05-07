
const calculateCidr = netmask => {
	const countCharOccurences = (string , char) => string.split(char).length - 1;

	const decimalToBinary = (dec) => (dec >>> 0).toString(2);
	const getNetMaskParts = (nmask) => nmask.split('.').map(Number);
	const netmask2CIDR = countCharOccurences(
		getNetMaskParts(netmask)
		.map(part => decimalToBinary(part))
		.join(''),
		'1'   
	);
    return {
		function: "maskToCidr",
		input: netmask,
		output: netmask2CIDR,
	}
}



module.exports = {
    calculateCidr,
}