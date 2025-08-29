# Simple Network Scanner

This Bash script performs a lightweight ping-based scan across a specified IP range within a local subnet. It’s designed for quick diagnostics and live device detection directly from the terminal.

## 📦 Features

- Interactive input for subnet and IP range
- Regex validation for subnet format
- Ping sweep with live/down status reporting
- Real-time terminal output
- Summary report of scanned devices

## 🛠️ How It Works

1. Prompts the user to enter:
   - First 3 octets of the network (e.g. `192.168.1`)
   - Start and end range for host IPs (e.g. `10` to `50`)
2. Validates the subnet format using regex
3. Iterates through the IP range and pings each host
4. Displays whether each host is UP or DOWN
5. Prints a final scan report with totals

## 🚀 Usage

```bash
chmod +x scanner.sh
./scanner.sh
```

## Example
Enter Network ID (e.g. 192.168.1): 192.168.1 <bR>
Enter the start range: 10 <bR>
Enter the end range: 20 <bR>

## Output:
✅ 192.168.1.10 is UP <bR>
❌ 192.168.1.11 is DOWN
...

## 📊 Scan Report:
Up Devices: 5 <bR>
Down Devices: 6  <bR>
Total Scanned: 11 <bR>

## 🧠 Notes
Works best on /24 subnets <bR>
Requires ICMP (ping) to be allowed by target devices <bR>
No external dependencies <bR>

## 👨‍💻 Author
Kyrillos Kamal <br>
Cybersecurity Trainee, IT & Network Engineer Focused on automation, scripting, and international IT support
