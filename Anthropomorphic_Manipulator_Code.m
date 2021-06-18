clc;
X =input('Enter x')
Y = input('Enter Y')
Z = input('Enter Z')
R1 = Link('revolute','d',0, 'a',0,'alpha',pi/2)
R2 = Link('revolute','d',0, 'a',-5,'alpha',0)
R3 = Link('revolute','d',0, 'a',-5,'alpha',pi/2)
R4 = Link('revolute','d',0.75, 'a',0,'alpha',pi/2)
R5 = Link('revolute','d',0, 'a',0,'alpha',-pi/2)
ROB = SerialLink([R1 R2 R3 R4 R5],'name','Right Arm')
ROB.base=SE3(3,0,0)
% figure(1)
% ROB.teach

L1 = Link('revolute','d',0, 'a',0,'alpha',pi/2)
L2 = Link('revolute','d',0, 'a',5,'alpha',0)
L3 = Link('revolute','d',0, 'a',5,'alpha',pi/2)
L4 = Link('revolute','d',0, 'a',0,'alpha',pi/2)
L5 = Link('revolute','d',0, 'a',0,'alpha',-pi/2)

TIR= transl(5,-2,2)
TIL= transl(0,2,-2)
T = transl(X,Y,Z)

TfR=ctraj(TIR,T,100)
TfL=ctraj(TIL,T,100)

ROB0 = SerialLink([L1 L2 L3 L4 L5],'name','Left Arm')
ROB0.base=SE3(-3,0,0)
% figure(2)
% ROB0.teach
q=ROB.ikine(TfR,'q0',[0 0 0 0 0],'mask',[1 1 1 0 0 0])
t=ROB0.ikine(TfL,'q0',[0 0 0 0 0],'mask',[1 1 1 0 0 0])
figure(3)
for i=1:5:100
    ROB0.plot(t(i,:));
    hold on
    ROB.plot(q(i,:));
end
