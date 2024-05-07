const validateQueryParam = (value, query) => query[value] ? query[value] : false;

module.exports = {
    validateQueryParam,
}