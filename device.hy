; A Tango device

(import [PyTango [DevState]])
(import [PyTango.server [run Device DeviceMeta attribute command device-property]])


(defclass HyDev [Device]
  [
   [__metaclass__ DeviceMeta]

   [init-device (fn [self]
                  (setv self.testAval 0)
                  (setv self.testBval 0)
                  None)]

   ; attributes
   [testA (apply attribute [] {'dtype int 'label "Test A" 'unit "hej"})]
   [read-testA (fn [self] self.testAval)]
   [write-testA (with-decorator testA.write
                  (fn [self value] (setv self.testAval value)))]

   [testB (apply attribute [] {'dtype float 'label "Test B"})]
   [read-testB (fn [self] self.testBval)]
   [write-testB (with-decorator testB.write
                  (fn [self value] (setv self.testBval value)))]

   ; commands
   [Multiply (with-decorator (apply command [] {'dtype-in int 'dtype-out int})
               (fn [self, x] (* x 2)))]

   [On (with-decorator command
         (fn [self] (self.set_state DevState.ON)))]

   [Off (with-decorator command
          (fn [self] (self.set_state DevState.OFF)))]

   ]
  )

(run [HyDev])
