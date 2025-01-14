document.addEventListener('DOMContentLoaded', function() {
    const materialsList = document.getElementById('materials-list');
    
    // Fetch the main repository contents
    fetch('https://api.github.com/repos/BastionDevs/unPlugged/contents')
        .then(response => response.json())
        .then(data => {
            const container = document.createElement('div');
            container.className = 'file-container';
            
            const allowedFolders = ['bypsrc', 'pldsrc'];
            
            data.forEach(item => {
                if (item.type === 'dir' && allowedFolders.includes(item.name)) {
                    const box = createFileBox(item);
                    container.appendChild(box);
                }
            });
            
            materialsList.innerHTML = '';
            materialsList.appendChild(container);
        })
        .catch(error => {
            console.error('Error fetching repository contents:', error);
            materialsList.textContent = 'Error loading repository contents. Please try again later.';
        });
});

function createFileBox(item) {
    const box = document.createElement('div');
    box.className = 'file-box';
    
    const icon = document.createElement('div');
    icon.className = 'file-icon ' + (item.type === 'dir' ? 'folder-icon' : 'file-icon');
    
    const name = document.createElement('div');
    name.className = 'file-name';
    
    // Remove file extension for display purposes
    const nameWithoutExtension = item.name.replace(/\.[^/.]+$/, "");
    name.textContent = nameWithoutExtension;
    
    box.appendChild(icon);
    box.appendChild(name);
    
    box.onclick = function() {
        if (item.type === 'file') {
            // Construct the raw URL for direct download
            const rawUrl = `https://raw.githubusercontent.com/BastionDevs/unPlugged/main/${item.path}`;
            downloadFile(rawUrl, item.name); // Call download function
        } else if (item.type === 'dir') {
            loadDirectory(item.url); // Load directory contents
        }
    };
    
    return box;
}

function downloadFile(url, fileName) {
    fetch(url)
        .then(response => response.blob()) // Fetch the file as a Blob
        .then(blob => {
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob); // Create a URL for the Blob
            link.download = fileName; // Set the filename for download
            
            // Append to body
            document.body.appendChild(link);
            
            // Trigger click to start download
            link.click();
            
            // Clean up and remove the link element
            document.body.removeChild(link);
        })
        .catch(error => {
            console.error('Error downloading file:', error);
        });
}

function loadDirectory(url) {
    fetch(url)
        .then(response => response.json())
        .then(data => {
            const container = document.createElement('div');
            container.className = 'file-container';
            
            data.forEach(item => {
                const box = createFileBox(item); // Create boxes for each item
                container.appendChild(box);
            });
            
            const materialsList = document.getElementById('materials-list');
            materialsList.innerHTML = '';
            materialsList.appendChild(container);
        })
        .catch(error => {
            console.error('Error loading directory:', error);
            document.getElementById('materials-list').textContent = 'Error loading directory. Please try again later.';
        });
}
