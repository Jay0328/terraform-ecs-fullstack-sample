import { execSync } from 'child_process';
import * as core from '@actions/core';

async function run(params) {
  const target = core.getInput('target');
  const type = core.getInput('type');

  const affectedInfos = execSync(
    `npx nx print-affected --target=${target} --type=${type}`,
    {
      encoding: 'utf-8',
    }
  );
  const { projects } = JSON.parse(affectedInfos);
  const stringifiedProjects = JSON.stringify(projects);
  const noAffected = projects.length === 0;

  process.stdout.write('\n');
  process.stdout.write(`projects: ${stringifiedProjects}\n`);
  process.stdout.write(`no-affected: ${noAffected}\n`);
  process.stdout.write('\n');
  core.setOutput('projects', stringifiedProjects);
  core.setOutput('no-affected', noAffected);
}

run();
