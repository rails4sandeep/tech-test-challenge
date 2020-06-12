browserOptions =
{
    logLevel: 'debug',
        capabilities: {
            browserName: 'chrome',
            'goog:chromeOptions': {
            args: ['--disable-setuid-sandbox', '--no-sandbox']
            }
    }
};

module.exports = browserOptions;

