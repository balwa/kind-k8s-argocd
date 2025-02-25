from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import HTMLResponse
import socket
import platform
import os
from datetime import datetime

# Initialize FastAPI application
app = FastAPI(
    title="GitOps Demo App",
    description="A sample FastAPI application for ArgoCD GitOps demonstration",
    version="1.0.0"
)

@app.get("/", response_class=HTMLResponse)
async def root():
    """Returns an HTML page with basic information about the pod"""
    hostname = socket.gethostname()
    html_content = f"""
    <!DOCTYPE html>
    <html>
        <head>
            <title>GitOps Demo App</title>
            <style>
                body {{
                    font-family: Arial, sans-serif;
                    max-width: 800px;
                    margin: 0 auto;
                    padding: 20px;
                    line-height: 1.6;
                }}
                .container {{
                    border: 1px solid #ddd;
                    border-radius: 8px;
                    padding: 20px;
                    margin-top: 20px;
                    background-color: #f9f9f9;
                }}
                h1 {{
                    color: #333;
                    border-bottom: 2px solid #eee;
                    padding-bottom: 10px;
                }}
                .info-item {{
                    margin-bottom: 10px;
                }}
                .label {{
                    font-weight: bold;
                    color: #555;
                }}
            </style>
        </head>
        <body>
            <h1>Welcome to GitOps Demo App! 🚀</h1>
            <div class="container">
                <div class="info-item">
                    <span class="label">Pod Hostname:</span> {hostname}
                </div>
                <div class="info-item">
                    <span class="label">Python Version:</span> {platform.python_version()}
                </div>
                <div class="info-item">
                    <span class="label">Platform Info:</span> {platform.platform()}
                </div>
                <div class="info-item">
                    <span class="label">Server Time:</span> {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
                </div>
                <div class="info-item">
                    <span class="label">Environment:</span> {os.getenv('ENV', 'development')}
                </div>
            </div>
            <div class="container">
                <h2>Available API Endpoints:</h2>
                <div class="info-item">
                    <span class="label">GET /ping:</span> Simple ping-pong response
                </div>
                <div class="info-item">
                    <span class="label">GET /health:</span> Health check endpoint
                </div>
                <div class="info-item">
                    <span class="label">GET /info:</span> System information in JSON format
                </div>
            </div>
        </body>
    </html>
    """
    return html_content

@app.get("/ping")
async def ping():
    """Simple ping-pong endpoint"""
    return {"message": "pong"}

@app.get("/health")
async def health():
    """Health check endpoint"""
    return {"status": "ok", "timestamp": datetime.now().isoformat()}

@app.get("/info")
async def info():
    """Returns system information"""
    return {
        "hostname": socket.gethostname(),
        "python_version": platform.python_version(),
        "platform": platform.platform(),
        "server_time": datetime.now().isoformat(),
        "environment": os.getenv("ENV", "development")
    }