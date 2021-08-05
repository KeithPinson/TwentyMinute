#!/usr/bin/env node

// commitCsv2json.js
//
// Node script to read the csv, parse, and export a json file.
//
// Note: Windows command prompt will not show csv unicode,
//       however Window Terminal will.
//
//
// Copyright (c) Keith Pinson.
//
//    @see [[LICENSE]] file in the root directory of this source.
//
const fs = require('fs');
const commander = require('commander');
const chalk = require('chalk');
const pkg = require('../package.json');
const path = require('path');

//
// Command Line Interface
// ----------------------
//
// const colorPaleGreen = '#98C379';
// const colorDarkSeaGreen = '#8FBC8F';
// const colorOrange = '#D19A66';
//const colorDarkKhaki = '#BDB76B';
// const colorAqua = '#56B6C2';
const colorTurquoise = '#33BBFF';
// const colorIceBlue = '#ABB2BF';
// const colorBlueGray = '#5C6370';
// const colorBgBlueGray = '#1E2127';
const colorBgDarkGray = '#212120';

const versionHex = colorTurquoise;
const versionBgHex = colorBgDarkGray;

const version = '1.0';
const versionCsvExample = chalk.hex(versionHex).bgHex(versionBgHex)(`
 ┌────────────────────────────────────────────────────────────────┐
 │  Name,Emoji,Code,Description                                   │
 │  access,"♿",":wheelchair:","Improvement for accessibility"    │
 │  asset,"📸",":camera_flash:","Add or update assets"            │
 │  ci,"👷",":construction_worker:","CI config files and scripts" │
 ⋮                                                                ⋮
`);
const versionCsvNotes = `
    • Top row is reserved for column headers
    • First column with the Type Name, is an un-quoted single word
    • Double-quotes are used on all elements in last 3 columns
`;
const versionRegx = chalk.hex(versionHex).bgHex(versionBgHex)(
  '(\\w+),\\w*"([^"]+)",\\w*"([^"]+)",\\w*"([^"]+)"',
);

commander
  // eslint-disable-next-line no-undef
  .name(chalk.keyword('darkseagreen').bgBlack(path.parse(__filename).name))
  .version('Commit CSV v' + version)
  .usage('[options] ' + chalk.keyword('darkkhaki').bgBlack('<csvfile>'))
  .description(chalk.gray.bgBlack('   Convert Commit Types from CSV to JSON'));

const sampleFileName = chalk.keyword('darkkhaki').bgBlack('commit-types.csv');

commander.addHelpText(
  'after',
  `
Example:
  $ ${commander.name()} ${sampleFileName}

CSV format: ${versionCsvExample} ${versionCsvNotes}
Regular Expression Used:
  ${versionRegx}  
  `,
);

//
// Markdown or JSON?
// -----------------
//
commander.program
  .option('-m, --markdown', 'convert to Markdown rather than JSON')
  .parse(process.argv);

const options = commander.opts();
const outputType = options.markdown ? 'md' : 'json';

//
// File Names
// ----------
//
let csvFileNameArg = commander.args.length > 0 ? commander.args[0] : '';
let outFileNameArg = commander.args.length > 1 ? commander.args[1] : '';

let csvFileNameParse = path.parse('');
let outFileNameParse = path.parse('');

if (csvFileNameArg.length > 0) {
  csvFileNameParse = path.parse(csvFileNameArg);

  // Process the output file name only if we had an input
  if (outFileNameArg.length > 0) {
    // We were given a second argument, assume it is the output file
    outFileNameParse = path.parse(outFileNameArg);
  } else {
    // Set the output file to be the same as input with a different extension
    outFileNameParse = path.parse(csvFileNameArg);
  }

  outFileNameParse.ext = outputType;
  outFileNameParse.base = outFileNameParse.name + '.' + outFileNameParse.ext;
}

const haveCsvFile = csvFileNameParse.base.length > 0;
const haveOutFile = outFileNameParse.base.length > 0;

//
// Show Usage
// ----------
//
const haveArgs = Object.keys(options).length !== 0;

// If no arguments or flags show just enough so they can try again
if (!haveCsvFile && !haveArgs) {
  console.log('Usage: ' + commander.name() + ' ' + commander.usage());
  console.log('');
  console.log(commander.description());
  console.log('');
  console.log('Options:');

  let flagLength = 0;
  for (var option of commander.options) {
    let l = option.flags.length;

    if (l > flagLength) {
      flagLength = l;
    }
  }

  for (var option of commander.options) {
    console.log(
      '  ' + option.flags.padEnd(flagLength) + '  ' + option.description,
    );
  }
  console.log(
    '  ' + commander._helpFlags + '\t  ' + commander._helpDescription,
  );
}

//
// Parse and Convert
// -----------------
//
if (haveCsvFile && haveOutFile) {
  const csvFile = path.format(csvFileNameParse);
  const outFile = path.format(outFileNameParse);

  let csv;
  let out = '';

  try {
    csv = fs.readFileSync(csvFile, {encoding: 'utf-8'});
  } catch (err) {
    if (err.code === 'ENOENT') {
      console.log(
        'File not found: ' + chalk.keyword('darkkhaki').bgBlack(csvFile),
      );
    }

    process.exit();
  }

  var eol = csv.indexOf('\r\n') > 0 ? '\r\n' : '\n';

  const lines = csv.split(eol);

  let re = /(\w+),\w*"([^"]+)",\w*"([^"]+)",\w*"([^"]+)"/;

  for (var n in lines) {
    if (n > 0) {
      let column = lines[n].match(re);

      if (column !== 'undefined' && column !== null) {
        // console.log(n, column[1], column[2], column[3], column[4]);
        if (outputType === 'json') {
          if (n > 1) {
            out += ',\n'; // Add the eol
          }

          out += '{\n';
          out += '  "emoji": "' + column[2] + '",\n';
          out += '  "code": "' + column[3] + '",\n';
          out += '  "description": "' + column[4] + '",\n';
          out += '  "name": "' + column[1] + '"\n';
          out += '}';
        } else if (outputType === 'md') {
          if (n > 1) {
            out += '\n'; // Add the eol
          }

          out += '|' + column[1];
          out += '|' + column[2];
          out += '|' + '`' + column[3] + '`';
          out += '|' + column[4];
          out += '|';
        }
      } else if (lines[n] !== '') {
        console.log('Line ' + n + ' malformed: ' + lines[n]);

        process.exit();
      }
    }
  }

  if (outputType === 'json') {
    out = `
{
  "config": {
    "cz-emoji": {
      "types": [
        ${out}
      ]
    }
  }
}
`;

    fs.writeFileSync(outFile, out, {encoding: 'utf-8'});
  } else if (outputType === 'md') {
    let mdHead =
      'The Commit Type answers "why" the commit was made. Everything can be changed ' +
      'except the letters of the Type name. More types can be added but the text of ' +
      'the Type should be frozen and treated as write-once.';

    out = `${mdHead}

| Type   | Emoji | Code           | Reason        |
| ------ | ----- | -------------- | ------------- |
${out}`;

    fs.writeFileSync(outFile, out, {encoding: 'utf-8'});
  }

  console.log(out);
}

// End of script
