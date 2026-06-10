-- OTP Dump Script created for Pretendo
--
-- If you can see this, you're one of the cool ones. ;)

if fs.exists("M:/otp_dec.mem") == false then
    ui.echo("Error: OTP Dec was not found.\nContact Pretendo support.")
    sys.power_off()
end

local one = util.bytes_to_hex(fs.read_file("M:/otp_dec.mem", 7, 1))
local two = util.bytes_to_hex(fs.read_file("M:/otp_dec.mem", 6, 1))
local three = util.bytes_to_hex(fs.read_file("M:/otp_dec.mem", 5, 1))
local four = util.bytes_to_hex(fs.read_file("M:/otp_dec.mem", 4, 1))

local deviceId = tostring(one..two..three..four)

if fs.exists("0:/luma/backups/"..deviceId) == false then
    fs.mkdir("0:/luma/backups/"..deviceId)
end

local success, result = pcall(fs.copy, "M:/otp.mem", "0:/luma/backups/"..deviceId.."/otp.bin", {no_cancel=true, silent=true, overwrite=true})
if success then
    ui.echo("OTP dumped successfully.\nPress A to power off.")
    sys.power_off()
else
    ui.show_qr("An error has occurred.\nContact Pretendo support\nand show them this QR.", tostring(result))
    sys.power_off()
end
