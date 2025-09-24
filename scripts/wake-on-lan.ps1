# --- Wake-on-LAN Script (Compatible with Windows PowerShell 5.1) ---

$macAddress = "54:05:db:05:65:cb"

# 1. Create the byte array from the MAC address string
$macBytes = $macAddress.Split(':') | ForEach-Object { [System.Convert]::ToByte($_, 16) }

# 2. Build the magic packet
# It starts with 6 bytes of 255 (0xFF)
$header = [byte[]](,0xFF * 6)
# Followed by the MAC address repeated 16 times
$payload = [byte[]]($macBytes * 16)
# Combine them into one packet
$magicPacket = $header + $payload

# 3. Send the packet using the .NET UdpClient
$udpClient = New-Object System.Net.Sockets.UdpClient
# Connect to the broadcast address on the standard WOL port (9)
$udpClient.Connect(([System.Net.IPAddress]::Broadcast), 9)
# Send the packet
$bytesSent = $udpClient.Send($magicPacket, $magicPacket.Length)

# 4. Clean up the UDP client
$udpClient.Close()

