const { remote } = require('webdriverio');
const options = require('../config/browser-options');

class Session {

    newSession = async () => {
        const session = await remote(options);
        return session;
    };

    closeSession = async (s) => {
        await s.deleteSession();
    };
}

module.exports = Session;
