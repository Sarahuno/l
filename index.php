<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make ⓤrl's Smaller</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #1f2326;
            color: #e1e1e1;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #2f3438;
            border: 2px solid #36404a;
            padding: 20px;
            border-radius: 10px;
            width: 400px; /* Adjust width as needed */
            display: flex;
            flex-direction: column;
            font-size: 20px;
            position: relative; /* Position relative for absolute positioning of elements */
        }
        .section {
            margin-bottom: 20px;
            border: none;
        }
        .text-container {
            line-height: 1.6;
            font-size: 18px;
            color: #c1c1c1;
            opacity: 0; /* Initially hidden */
            animation: fadeIn 1s ease forwards; /* Fade-in animation */
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        .input-container {
            margin-bottom: 10px;
        }
        .input-container label {
            display: block;
            margin-bottom: 5px;
            color: #c1c1c1;
        }
        .input-container input[type="url"],
        .input-container input[type="text"] {
            width: calc(100% - 22px); /* Adjusted width */
            padding: 10px;
            font-size: 16px;
            border: 1px solid #36404a;
            border-radius: 5px;
            background-color: #39424f;
            color: #c1c1c1;
            transition: border-color 0.3s ease;
        }
        .input-container input[type="url"]:focus,
        .input-container input[type="text"]:focus {
            border-color: #445063;
            outline: none;
        }
        .btn {
            display: inline-block;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            background-color: #39424f;
            font-size: 18px;
            color: #c1c1c1;
            opacity: 0; /* Initially hidden */
            animation: slideIn 0.5s ease forwards; /* Slide-in animation */
            cursor: pointer;
            text-decoration: none;
            width: 100%; /* Adjusted width to fill container */
            height: auto;
            text-align: center; /* Centering text */
        }
        @keyframes slideIn {
            from {
                transform: translateX(-20%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        .btn:hover {
            background-color: #445063;
        }
        .btn:focus {
            outline: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="section">
        <h2>Cⓤmify A ⓤrl</h2>
        <div class="text-container">
            Welcome to Lίnk-Minifier! Input your lengthy ⓤRL below to generate a Compact ⓤRL.
        </div>
    </div>
    <div class="section">
        <form action="s.php" method="POST" class="input-container" id="urlForm" onsubmit="return validateForm()">
            <label for="longUrl">Enter Long URL:</label>
            <input type="url" id="longUrl" name="longUrl" required maxlength="100">

            <label for="vanity">Custom Alias (optional):</label>
            <input type="text" id="vanity" name="vanity">

            <button type="submit" class="btn">Generate Compact URL</button>
        </form>
        <div id="warningMessage" class="warning" style="display: none;">URL length cannot exceed 130 characters.</div>
    </div>
    </div>

    <script>
        function validateForm() {
            var longUrlInput = document.getElementById('longUrl');
            var warningMessage = document.getElementById('warningMessage');

            if (longUrlInput.value.length > 130) {
                warningMessage.style.display = 'block';
                return false; // Prevent form submission
            } else {
                warningMessage.style.display = 'none';
                return true; // Allow form submission
            }
        }
    </script>


</body>
</html>
