
class Page {

    constructor(browser) {
        this.b = browser;
    };

    goto = async pageUrl => {
        await this.b.url(pageUrl);
    };

    getElementByXpath = async xpath => {
        return $(xpath);
    };

    scrollElementIntoView = async element => {
        const status = await element.isDisplayedInViewport();
        if (status) {
            return;
        }
        await element.scrollIntoView();
    };

    clickElement = async id => {
        const e = await this.b.$(id);
        await e.waitForDisplayed();
        await this.scrollElementIntoView(e);
        await e.click();
    };

    pressSpecialKeys = async seq => {
        await this.b.keys(seq);
    };

    breath = async millisec => {
        await this.b.pause(millisec);
    };

    getTitle = async () => {
        const title = await this.b.getTitle();
        return title;
    };

    close = async () => {
        await this.b.deleteSession();
    };

    waitForElement = async (e) => {
        await this.b.waitForDisplayed(e);
    };

    getAttributeValue = async (element,attribute) => {
        return (await element.getAttribute(attribute));
    };

    isElementDisplayed = async (element) => {
        await element.waitForDisplayed();
        return (await element.isDisplayed());
    };
}

module.exports = Page;
