DefinitionBlock ("", "SSDT", 2, "HACK", "PNLF", 0x00000000)
{
    External (_SB.PCI0.IGPU, DeviceObj)

    Scope (_SB.PCI0.IGPU)
    {
        Device (PNLF)
        {
            Name (_ADR, Zero)
            Name (_HID, EisaId ("APP0002"))
            Name (_CID, "backlight")
            Name (_UID, 0x0A)
            Name (_STA, 0x0B)

            Method (_BCL, 0, NotSerialized)
            {
                Return (Package (0x0C)
                {
                    0x00,      /* min */
                    0x28,      /* AC min = 40 decimal */
                    0xFF,      /* max = 255 decimal */
                    50, 75, 100, 125, 150, 175, 200, 225, 255
                })
            }

            Method (_BCM, 1, NotSerialized)
            {
                /* Arg0 = brightness (0..255)
                   Keep this stub minimal; AppleBacklight may handle writes itself.
                   If needed, implement GPU register writes here or forward to handler. */
                Store (Arg0, Local0)
                Return (Local0)
            }

            Method (_BQC, 0, NotSerialized)
            {
                /* Return a default current brightness */
                Return (0x80)
            }
        }
    }
}
