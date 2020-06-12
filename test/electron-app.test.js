const Page = require('../pop/page');
const Session = require('../pop/session');
const session = new Session();
let browser, page;
const electronApp = require('../pop/electron-app');

describe('Electron App', () => {

    beforeEach(async () => {
        setTimeout(30000);
        browser = await session.newSession();
        page = new Page(browser);
    });

    afterEach(async () => {
        await session.closeSession(browser);
    });

    it('should highlight the red finding 2 page element if the result received from webservice is critical', async () => {
        await page.goto('https://electron-app.harrison.ai');
        await page.clickElement(electronApp.image);
        await page.waitForElement(page.getElementByXpath(electronApp.finding2));
        const critical = await page.getAttributeValue(page.getElementByXpath(electronApp.finding2),'highlighted');
        expect(critical).toBe('true');
    });

    it('should highlight the green finding 1 page element if the result received from webservice is not critical', async () => {
        await page.goto('https://electron-app.harrison.ai');
        await page.clickElement(electronApp.image);
        await page.waitForElement(page.getElementByXpath(electronApp.finding1));
        const critical = await page.getAttributeValue(page.getElementByXpath(electronApp.finding1),'highlighted');
        expect(critical).toBe('true');
    });

    it('should show an error message if there is a time out from the webservice', async () => {
        await page.goto('https://electron-app.harrison.ai');
        await page.clickElement(electronApp.image);
        const isElementDisplayed = await page.isElementDisplayed(page.getElementByXpath(electronApp.errorTimeout));
        expect(isElementDisplayed).toBe('true');
    });

    it('should show an error message if the electron app loses the internet connection', async () => {
        await page.goto('https://electron-app.harrison.ai');
        await page.clickElement(electronApp.image);
        const isElementDisplayed = await page.isElementDisplayed(page.getElementByXpath(electronApp.errorNoInternet));
        expect(isElementDisplayed).toBe('true');
    });

    it('should show an error message if there is an error response received from the webservice', async () => {
        await page.goto('https://electron-app.harrison.ai');
        await page.clickElement(electronApp.image);
        const isElementDisplayed = await page.isElementDisplayed(page.getElementByXpath(electronApp.errorResponseFromWS));
        expect(isElementDisplayed).toBe('true');
    });

});
