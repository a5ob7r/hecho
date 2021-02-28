{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.ByteString.Char8 as BS8
import Network.Simple.TCP

hechoServer :: HostPreference -> ServiceName -> IO ()
hechoServer host port = do
  putStrLn "Start hecho server"
  putStrLn $ "HOST: " <> show host
  putStrLn $ "PORT: " <> show port
  serve host port $ \(sock, addr) -> do
    bytes <- recv sock 1000
    maybe (BS8.putStrLn "Fail to receive data") BS8.putStrLn bytes
    send sock "Hi, I'm hecho!"

main :: IO ()
main = hechoServer "localhost" "8888"
