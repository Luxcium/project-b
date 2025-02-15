const { execSync } = require('child_process');
const { checkDockerStatus, startDocker, validateConnectivity } = require('../scripts/check-docker.sh');

class ClineAgent {
  constructor() {
    this.dockerRunning = false;
  }

  recognizeDatabaseNeed() {
    // Logic to recognize when the PostgreSQL database is needed
    return true; // Placeholder logic
  }

  ensureDockerRunning() {
    try {
      execSync('docker info');
      this.dockerRunning = true;
    } catch (error) {
      this.dockerRunning = false;
    }

    if (!this.dockerRunning) {
      console.log('Docker is not running. Starting Docker...');
      startDocker();
      this.dockerRunning = true;
    } else {
      console.log('Docker is already running.');
    }
  }

  startDatabase() {
    if (this.dockerRunning) {
      console.log('Starting the PostgreSQL database using docker-compose...');
      execSync('docker-compose up -d');
    } else {
      console.log('Docker is not running. Cannot start the PostgreSQL database.');
    }
  }

  validateDatabaseConnectivity() {
    if (this.dockerRunning) {
      console.log('Validating PostgreSQL database connectivity...');
      validateConnectivity();
    } else {
      console.log('Docker is not running. Cannot validate PostgreSQL database connectivity.');
    }
  }

  run() {
    if (this.recognizeDatabaseNeed()) {
      this.ensureDockerRunning();
      this.startDatabase();
      this.validateDatabaseConnectivity();
    }
  }
}

module.exports = ClineAgent;
