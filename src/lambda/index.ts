import { Handler } from 'aws-lambda';

export const handler: Handler = async (_event, _context, callback) => {
    try {
        return callback(null, {
            statusCode: 200,
            body: 'Success!!!',
        });
    } catch (err: any) {
        console.log('error');
        return callback(err);
    }
};
