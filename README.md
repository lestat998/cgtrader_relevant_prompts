# Cgtrader Relevant Prompts Application README

## Description
Relevant Prompts is a Ruby on Rails application crafted to aid users in discovering the most pertinent prompts tailored to their specific input. This prototype stands out with its straightforward yet highly functional web interface, which facilitates effortless querying within a diverse dataset of prompts. The application is powered by a harmonious integration of Ruby on Rails, PostgreSQL, and ElasticSearch, ensuring swift and accurate retrieval of search results. The application invites users to type in their desired keywords and press the `Enter` key. This seamless interaction ensures a user-friendly experience, making finding precise prompts efficient and enjoyable.

## Features
- **User-Friendly Interface**: Easy-to-use web interface for prompt searching.
- **Efficient Searching**: Integrated with ElasticSearch for quick and relevant search results.
- **Dockerized Environment**: For easy setup and deployment.

## Tech Stack
- **Ruby on Rails**: A robust web application framework.
- **PostgreSQL**: For database management.
- **ElasticSearch**: A search engine enabling efficient data querying.
- **Docker**: Used for containerization of the application.

## Getting Started

### Prerequisites
- Docker
- Docker Compose

### Installation
1. **Clone the Repository**:
   ```
   git clone https://github.com/lestat998/cgtrader_relevant_prompts
   ```
2. **Navigate to the Repository**:
   ```
   cd [repository-name]
   ```
3. **Grant Execution Permission to `up.sh` Script**:
   ```
   chmod +x up.sh
   ```
   This step ensures that the `up.sh` script can be executed, which is necessary for setting up the Docker environment.
4. **Build the Docker Images**:
   ```
   docker-compose build
   ```
5. **Start the Application**:
   ```
   docker-compose up
   ```

### Data Indexing
- **Create an Index with the Dataset**:
  ```
  docker-compose run web rails hugging_face:import
  ```
  This initializes the ElasticSearch index with the provided dataset.

## Usage
- **Access the Application**: Visit [Relevant Prompts App](https://cgtrader-relevant-prompts-f3e130991737.herokuapp.com/) in your web browser.
- **Search Prompts**: Enter words in the search bar and hit `Enter` to trigger the search for relevant prompts.

## Author
- **Javier Jimenez**
