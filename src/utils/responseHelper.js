exports.success = (res, data, message = 'Success', status = 200) => {
    res.status(status).json({
        status: 'success',
        message,
        data
    });
};

exports.error = (res, message = 'Internal Server Error', status = 500) => {
    res.status(status).json({
        status: 'error',
        message
    });
};
