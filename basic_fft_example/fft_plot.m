

% Örnekleme frekansı ve zaman vektörü
Fs = 1000000;  % Örnekleme frekansı (örneğin 100 kHz)
t = (0:1023) / Fs;  % Zaman vektörü (1024 nokta)

% Beyaz gürültü oluşturma
amplitude_w =2; %sinyal amplitude artırmak veya azaltmak için kullanılır
white_noise = amplitude_w*randn(size(t));

% Laser Doppler sinyali oluşturma
f_carrier = 100000;  % Taşıyıcı frekans (örneğin 10 kHz)
modulation_index = 0.5;  % Modülasyon indeksi
%laser_doppler = cos(2 * pi * f_carrier * t + modulation_index * sin(2 * pi * 100 * t));
%t1_start =0.0005;
%num_cycles = 1;
%laser_doppler = 3*cos(2 * pi * f_carrier * (t - t1_start) * num_cycles) .* (t >= t1_start & t < (t1_start + 1/f_carrier));
Ta = 0.0002;  % Sinyalin başlama zamanı (örneğin 0.002 saniye)
Tb = Ta + (1/f_carrier)*50;  % Sinyalin durma zamanı buradaki 5(cycle) sinyal uzunluğunu ayarlamak için değiştirlebilir
amplitude_l =2; %sinyal amplitude artırmak veya azaltmak için kullanılır
laser_doppler = amplitude_l * cos(2 * pi * f_carrier * (t - Ta) ) .* (t >= Ta & t < Tb);

% Toplam sinyal (beyaz gürültü + laser doppler)
signal = white_noise + laser_doppler;

% FFT hesaplama
N = 1024;  % FFT uzunluğu (1024 nokta)
Y = fft(signal(1:N));  % Verinin ilk N örneğini alarak FFT hesapla

% Frekans eksenini oluşturma
f = (0:N-1) * Fs / N;  % Frekans eksenini Hertz cinsinden hesapla

% FFT sonucunu amplitüd ile normalize etme
Y_normalized = abs(Y) / N;  % Amplitüd normalizasyonu

% FFT sonucunu tek taraflı spektrum olarak düzenleme
Y_single_side = Y_normalized(1:N/2 + 1);  % Tek taraflı spektrum için gerekli bölüm
f_single_side = f(1:N/2 + 1);  % Tek taraflı frekans eksenini oluştur

% FFT sonucunu ve sinyali plot etme
figure;


% white Noise Sinyali zaman domaininde plot et
subplot(4, 1, 1);
plot(t, white_noise);
title('White Noise');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% doppler Sinyali zaman domaininde plot et
subplot(4, 1, 2);
plot(t, laser_doppler);
title('10 kHz Laser Doppler Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Doppler+ white Noise Sinyali zaman domaininde plot et
subplot(4, 1, 3);
plot(t, signal);
title('White Noise + 10 kHz Laser Doppler Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% FFT sonucunu frekans domaininde plot et
subplot(4, 1, 4);
plot(f_single_side, Y_single_side);
title('FFT of White Noise + 10 kHz Laser Doppler Signal');
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');
grid on;
