%% Lab 3 Main Script
n = load('normal.mat');
f = load('fast.mat');

%% Analysis applied to fast and normal data
data.Normal = n;
data.Fast = f;
fn = fieldnames(data);

for i = 1:length(fieldnames(data))

    % filter analog and marker
    [GRF, COPx, COPz] = analogfilter_v2(data.(fn{i}).analogdata);
    [filterdata] = markerfilter(data.(fn{i}).markerposition);

    % Assign markers to anatomical joints
    rShldr = filterdata(:, :, 2);
    rTroch = filterdata(:, :, 4);
    rKnee = filterdata(:, :, 5);
    rAnkle = filterdata(:, :, 6);
    rHeel = filterdata(:, :, 7);
    rToe = filterdata(:, :, 8);

    trunkAngle = segmentangle(rShldr, rTroch);
    thighAngle = segmentangle(rTroch, rKnee);
    shankAngle = segmentangle(rKnee, rAnkle);
    footAngle = segmentangle(rHeel, rToe);

    % Calculate segment angular velocities and accelerations
    Fs = 100;
    [trunkAngleVel, trunkAngleAcc] = angVelAcc(trunkAngle, Fs);
    [thighAngleVel, thighAngleAcc] = angVelAcc(thighAngle, Fs);
    [shankAngleVel, shankAngleAcc] = angVelAcc(shankAngle, Fs);
    [footAngleVel, footAngleAcc] = angVelAcc(footAngle, Fs);

    % Calculate joint angular velocities
    hipAngleVel = thighAngleVel - trunkAngleVel;
    kneeAngleVel = shankAngleVel - thighAngleVel;
    ankleAngleVel = footAngleVel - shankAngleVel;

    % Calculate COM acceleration for each segment
    thighCOM = 0.3612 * (rKnee - rTroch) + rTroch;
    shankCOM = 0.4416 * (rAnkle - rKnee) + rKnee;
    footCOM = 0.4014 * (rToe - rHeel) + rHeel;

    [thighVel, thighAcc] = velAcc(thighCOM, Fs);
    [shankVel, shankAcc] = velAcc(shankCOM, Fs);
    [footVel, footAcc] = velAcc(footCOM, Fs);

    % Mass and inertia terms
    thighMass = 49.9 .* 0.1478;
    thighLength = rKnee - rTroch;
    thighInertia = [thighMass .* (thighLength(1,:) .* 0.364).^2;
        thighMass .* (thighLength(2,:) .* 0.162).^2;
        thighMass .* (thighLength(3,:) .* 0.369).^2];


    shankMass = 49.9 * 0.0481;
    shankLength = rAnkle - rKnee;
    shankInertia = [shankMass .* (shankLength(1,:) .* 0.267).^2;
        shankMass .* (shankLength(2,:) .* 0.093).^2;
        shankMass .* (shankLength(3,:) .* 0.271).^2];

    footMass = 49.9 * 0.0129;
    footLength = rToe - rAnkle;
    footInertia = [footMass .* (footLength(1,:) .* 0.279).^2;
        footMass .* (footLength(2,:) .* 0.139).^2;
        footMass .* (footLength(3,:) .* 0.299).^2];

    % Perform inverse dynamics
    [ankleForce, ankleMoment] = invDynamics(footMass, footAcc, GRF(1:3,:), ...
        zeros(3, size(GRF, 2)), footInertia, footAngleAcc, footAngleVel, ...
        footCOM, rAnkle, [COPx'; zeros(1, size(GRF, 2)); COPz']);

    [kneeForce, kneeMoment] = invDynamics(shankMass, shankAcc, ...
        (ankleForce .* -1),(ankleMoment .* -1), shankInertia, shankAngleAcc, ...
        shankAngleVel, shankCOM, rKnee, rAnkle);

    [hipForce, hipMoment] = invDynamics(thighMass, thighAcc, ...
        (kneeForce * -1), (kneeMoment .* -1), thighInertia, thighAngleAcc, ...
        thighAngleVel, thighCOM, rTroch, rKnee);

    % Calculate stride length and cadence
    max1 = rHeel(1,:)-rTroch(1,:);
    slmax = find(islocalmax(max1));
    strideLength = max(max1) + max(max1 .* -1);
    cadence = 60 ./ (((slmax(:,2) - slmax(:,1)) ./ 2) ./ Fs);

    % Joint power
    hipPower = dot(hipAngleVel, hipMoment);
    kneePower = dot(kneeAngleVel, kneeMoment);
    anklePower = dot(ankleAngleVel, ankleMoment);

    % Moment
    figure(1)
    eval(sprintf("subplot(2, 2, %d)", i))
    plot(ankleMoment(3, (slmax(:,1):slmax(:,2))'));
    hold on
    plot(kneeMoment(3, (slmax(:,1):slmax(:,2))'));
    hold on
    plot(hipMoment(3, (slmax(:,1):slmax(:,2))'));
    title(strcat("Moment- ", fn{i}, " Gait"))

    % Power
    eval(sprintf("subplot(2, 2, %d)", 2 + i))
    plot(anklePower((slmax(:,1):slmax(:,2))'));
    hold on
    plot(kneePower((slmax(:,1):slmax(:,2))'));
    hold on
    plot(hipPower((slmax(:,1):slmax(:,2))'));
    title(strcat("Power- ", fn{i}, " Gait"))

end