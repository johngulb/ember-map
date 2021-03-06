'use strict';

const browsers = [
  'last 5 Chrome versions',
  'last 5 Firefox versions',
  'last 5 Safari versions'
];

const isCI = !!process.env.CI;
const isProduction = process.env.EMBER_ENV === 'production';

if (isCI || isProduction) {
  browsers.push('ie 11');
}

module.exports = {
  browsers
};
