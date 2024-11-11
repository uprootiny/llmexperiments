#!/bin/bash

# Setup script for initializing a comprehensive project workflow

# Step 1: Create Project Directory
PROJECT_NAME="Hypertopic_Project_AI_Manifestations"
PROJECT_DIR=$(echo "$PROJECT_NAME" | tr ' ' '_')
echo "Creating project directory: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || exit

# Step 2: Initialize Git Repository
echo "Initializing Git repository..."
git init

# Step 3: Create README.md
echo "Creating README.md..."
cat <<EOL > README.md
# $PROJECT_NAME

This project explores the latent space topologies of project embeddings to identify potential project genres and generate setup scripts for iterative project development.

## Workflow Overview
1. Generate embeddings for project ideas.
2. Cluster embeddings to identify related themes.
3. Generate setup scripts for clustered project themes.
4. Automate LLM interactions for project seeding and management.

## Setup and Usage
Run the following scripts to kickstart your workflow:

- \`generate_embeddings.sh\`: Generates embeddings for input project ideas.
- \`cluster_embeddings.sh\`: Clusters the embeddings into themes.
- \`generate_setup_scripts.sh\`: Generates setup scripts for each identified project cluster.

EOL

# Step 4: Install Dependencies
echo "Installing dependencies..."
# Install jq for JSON parsing
if ! command -v jq &> /dev/null; then
  echo "Installing jq..."
  sudo apt-get update && sudo apt-get install -y jq
fi

# Install other dependencies if required (e.g., Python packages)
echo "Checking Python packages..."
pip install transformers clj-ml

# Step 5: Create Babashka Script for Automation
echo "Creating Babashka script: forage.clj"
cat <<'EOF' > forage.clj
#!/usr/bin/env bb

(require '[clojure.pprint :refer [pprint]])
(require '[clojure.java.shell :refer [sh]])

(defn generate-embedding [text]
  ;; Simulate embedding generation
  (vec (repeatedly 128 #(rand))))

(defn cluster-embeddings [embeddings]
  ;; Dummy clustering function (replace with actual clustering logic)
  (map (fn [e] (mod (reduce + e) 3)) embeddings))

(def project-ideas
  {:technology
   {:development
    ["LLM Iterative Development"
     "Transformers in Go LLM"
     "LLM Experiment Setup Session"]}})

(defn main []
  (let [all-titles (mapcat identity (vals (vals project-ideas)))
        embeddings (into {} (for [title all-titles]
                              [title {:embedding (generate-embedding title)}]))
        clustered (cluster-embeddings (map :embedding (vals embeddings)))]
    (pprint embeddings)
    (println "\nClustering complete.")
    ;; Generate setup scripts here
    (doseq [title all-titles]
      (spit (str (clojure.string/replace title #" " "_") "_setup.sh")
            (str "#!/bin/bash\n\n# Setup script for " title "\necho \"Setting up " title "...\"")))
    (println "All setup scripts generated.")))

(main)
EOF

chmod +x forage.clj

# Step 6: Run Babashka Script to Generate Initial Scripts
echo "Running Babashka script to generate setup scripts..."
./forage.clj

# Step 7: Create Taskfile for Managing Tasks
echo "Creating Taskfile.yaml..."
cat <<EOL > Taskfile.yaml
version: "3"

tasks:
  generate_completion:
    desc: "Generate a single completion"
    cmds:
      - ./scripts/generate_completion.sh "llama3:latest" "Explain AI project embeddings."

  cluster_embeddings:
    desc: "Cluster project embeddings"
    cmd
