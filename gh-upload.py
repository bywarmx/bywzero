#!/usr/bin/env python3
import os
import subprocess
import getpass

def run_cmd(cmd):
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    except subprocess.CalledProcessError:
        return False

def upload():
    # Set default username
    username_input = input("GitHub Username [default: bywarmx]: ").strip()
    username = username_input if username_input else "bywarmx"
    
    # Extract repo name from README.md or current directory
    repo = ""
    filename = "README.md"
    if os.path.exists(filename):
        try:
            with open(filename, 'r') as f:
                for line in f:
                    if line.startswith("#"):
                        title = line.replace("#", "").strip().split(":")[0].strip()
                        repo = "".join(c for c in title if c.isalnum() or c in " -_").replace(" ", "-").lower()
                        break
        except Exception:
            pass
    if not repo:
        repo = os.path.basename(os.getcwd())
        
    print(f"[*] Repository Name (from README): {repo}")
        
    token = getpass.getpass("GitHub Personal Access Token (hidden): ").strip()
    
    if not token:
        print("[!] Token is required.")
        return

    # Automatically create the repository on GitHub if it doesn't exist
    import urllib.request
    import urllib.error
    import json
    
    print(f"[*] Checking/creating remote repository '{repo}'...")
    api_url = "https://api.github.com/user/repos"
    headers = {
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github.v3+json",
        "Content-Type": "application/json",
        "User-Agent": "SLIVER-Uploader"
    }
    # Create as public by default
    post_data = json.dumps({"name": repo, "private": False}).encode("utf-8")
    req = urllib.request.Request(api_url, data=post_data, headers=headers, method="POST")
    try:
        with urllib.request.urlopen(req) as response:
            if response.status == 201:
                print(f"[+] Successfully created new repository '{repo}' on GitHub!")
    except urllib.error.HTTPError as e:
        if e.code == 422:
            print(f"[*] Repository '{repo}' already exists on your GitHub account. Proceeding to push...")
        else:
            print(f"[!] API Error ({e.code}): {e.read().decode('utf-8')}")
            print("[*] Attempting push anyway...")
    except Exception as e:
        print(f"[!] Network Error: {e}")
        print("[*] Attempting push anyway...")

    # Git initialization
    run_cmd("git init")
    
    # Configure local git identity for this repo if not globally configured
    run_cmd(f'git config user.name "{username}"')
    run_cmd(f'git config user.email "{username}@users.noreply.github.com"')
    
    run_cmd("git add .")
    run_cmd('git commit -m "feat: init SLIVER token optimizer"')
    run_cmd("git branch -M main")
    
    # Configure remote with authenticated URL
    remote_url = f"https://{username}:{token}@github.com/{username}/{repo}.git"
    run_cmd("git remote remove origin")
    run_cmd(f"git remote add origin {remote_url}")
    
    print("[*] Uploading to GitHub...")
    if run_cmd("git push -u origin main"):
        print("[+] Repository successfully uploaded to GitHub!")
    else:
        print("[!] Upload failed. Verify repository existence and token permissions.")

if __name__ == "__main__":
    upload()
